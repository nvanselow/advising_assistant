class Flash {
  static success(message){
    Materialize.toast(message, 4000, 'alert success');
  }

  static error(message){
    Materialize.toast(message, 4000, 'alert error');
  }

  static standard(message){
    Materialize.toast(message, 4000, 'alert');
  }
}

export default Flash;
