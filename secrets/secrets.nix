let
  mk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0pgeFz9tatfDPKmDAaLu5QHnSvsXLIlO0NDg1NUtUS";
  users = [ mk ];
in
{
  "secret1.age".publicKeys = users;
}

