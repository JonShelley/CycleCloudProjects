#!/bin/bash

# Determine the OS version
version=`/bin/bash /usr/local/reframe/azure_nhc/slurm/common.sh`

if [ "$version" == "centos-7" ]
then
    export PATH=/opt/rh/rh-python38/root/usr/bin:$PATH
elif [ "$version" == "centos-8" ]
then
    #Nothing yet
    a="5"
fi

set -x

function run_reframe {
    echo "Hello run_reframe()"
    # Setup environment
    cd /usr/local/reframe
    . share/completions/reframe.bash

    # Run reframe tests
    . /etc/profile.d/modules.sh
    mkdir -p /mnt/resource/reframe/reports
    ./bin/reframe -C azure_nhc/config/azure_ex.py --report-file /mnt/resource/reframe/reports/cc-slurm-prologue.json -c azure_nhc/run_level_1 -s /mnt/resource/reframe/stage -o /mnt/resource/reframe/output -R -r --performance-report

}

function check_reframe {
    echo "Hello check_reframe"
    # Get VM ID
    vmId=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2019-06-04" | jq '.compute.vmId')

    # Get Reframe error
    status=$(python3 /usr/local/reframe/azure_nhc/slurm/check_reframe_report.py)

    # Add the VM ID and error to the jetpack log
    jetpack log "$HOSTNAME:$vmId:$status"

    # Place the node in a drained state
    scontrol update nodename=$HOSTNAME state=DRAIN Reason="$status"

    # If possible, trigger IcM ticket and get it out of rotation
}

trap check_reframe ERR

run_reframe
