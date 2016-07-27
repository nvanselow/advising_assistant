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

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
