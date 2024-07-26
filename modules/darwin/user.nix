{
  myvars,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${myvars.userName}" = {
    home = "/Users/${myvars.userName}";
    description = myvars.userFullName;
  };

}
