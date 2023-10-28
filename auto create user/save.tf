resource "local_file" "user" {
  filename = "users.csv"
  content  = <<EOF
username,password
${join("\n", [for username, pass in local.user_data : "${username},${pass}"])}
EOF
}

resource "local_file" "user_null" {
  filename = "users_null.csv"
  content  = <<EOF
username,password
${join("\n", [for username, pass in local.user_data_null : "${username},${pass}"])}
EOF
}

resource "local_file" "user_custom" {
  filename = "users_custom.csv"
  content  = <<EOF
username,password
${join("\n", [for username, pass in local.user_data_custom : "${username},${pass}"])}
EOF
}
