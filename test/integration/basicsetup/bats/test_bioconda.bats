#!/usr/bin/env bats

@test "conda is found for login user" {
  sudo -u vagrant bash -l -c 'set > /tmp/c.txt'
  run sudo -u vagrant bash -l -c 'which conda'
  [ "$status" -eq 0 ]
}


@test "sailfish is install for login user" {
  # sailfish is not install current environment
  run sudo -u vagrant bash -l -c 'which sailfish'
  [ "$status" -ne 0 ]
  # remove old environment mainly for run test several times like debug phase
  sudo -u vagrant bash -l -c 'conda env remove -y -n mytestkitchenenvironment'
  # create and new conda environment and install sailfish
  sudo -u vagrant bash -l -c 'conda create -y -n mytestkitchenenvironment sailfish'
  # test sailfish is exists
  run sudo -u vagrant bash -l -c 'source activate mytestkitchenenvironment ; which sailfish'
  [ "$status" -eq 0 ]
}
