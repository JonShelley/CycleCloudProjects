#!/bin/bash

set -x

# Copy slurm files to the correct location
cp -R ${CYCLECLOUD_SPEC_PATH}/files/slurm /usr/local/reframe/azure_nhc/.
cp -R ${CYCLECLOUD_SPEC_PATH}/files/common.sh /usr/local/reframe/azure_nhc/slurm/.

# Configure slurm prologue
# Do we do this in the template?


