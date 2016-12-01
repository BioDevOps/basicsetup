#!/usr/bin/env bats

@test "conda is found for login user" {
  sudo -u vagrant bash -l -c 'set > /tmp/c.txt'
  run sudo -u vagrant bash -l -c 'which conda'
  [ "$status" -eq 0 ]
}


@test "bwa is install for login user" {
  # bwa is not install current environment
  run sudo -u vagrant bash -l -c 'which bwa'
  [ "$status" -ne 0 ]
  # remove old environment mainly for run test several times like debug phase
  sudo -u vagrant bash -l -c 'conda env remove -y -n mytestkitchenenvironment'
  # create and new conda environment and install bwa
  sudo -u vagrant bash -l -c 'conda create -y -n mytestkitchenenvironment bwa=0.7.12'
  # test bwa is exists
  run sudo -u vagrant bash -l -c 'source activate mytestkitchenenvironment ; which bwa'
  [ "$status" -eq 0 ]
}
