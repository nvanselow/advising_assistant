class Api::V1::CoursesController < ApiController
  before_filter :authenticate_user!

  def create
    semester = Semester.find(params[:semester_id])
    course = semester.courses.new(course_params)

    if course.save
      render json: { message: 'Course created!', course: course }, status: :ok
    else
      errors = course.errors.full_messages
      render json: { message: 'There was a problem creating that course',
                     errors: errors }, status: :bad_request
    end
  end

  def update
    course = Course.find(params[:id])
    course.semester_id = params[:new_semester_id]

    if course.save
      render json: { message: 'Course moved!', course: course }
    else
      errors = course.errors.full_messages
      render json: {
        message: 'There was a problem moving that course.',
        errors: errors
      }, status: :bad_request
    end
  end

  def destroy
    course_id = params[:id]
    Course.destroy(course_id)
    render json: { message: 'Course deleted!', course_id: course_id }
  end

  private

  def course_params
    params[:course][:credits] = (params[:course][:credits].to_f * 10).round
    params.require(:course).permit(:name, :credits)
  end
end
