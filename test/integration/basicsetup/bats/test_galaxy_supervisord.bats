#!/usr/bin/env bats

@test "Galaxy is running on 28080" {
  wget http://localhost:28080 -O - > /tmp/galaxy.txt
  run bash -c "wget http://localhost:28080 -O - | grep Galaxy &> /dev/null"
  [ "$status" -eq 0 ]
}
@test "Supervisord is running on 29002" {
  wget http://localhost:29002 -O - > /tmp/supervisord.txt 
  run bash -c "wget http://localhost:29002 -O - | grep -i supervisor"
  [ "$status" -eq 0 ]
}
