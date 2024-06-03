#!/bin/bash

# Function to pull images from a team's repository
pull_images() {
    team=$1
    # You can specify the tags you want to pull here, for example: tags=("latest" "v1.0" "v2.0")
    images=("main" "autonomy" "nlp" "asr" "vlm")
    
    for image in "${images[@]}"; do
        docker pull "asia-southeast1-docker.pkg.dev/dsta-angelhack/repository-$team/$team-$image:finals"
        if ! [ $? -eq 0 ] ; then
            docker pull "asia-southeast1-docker.pkg.dev/dsta-angelhack/repository-$team/$team-$image:latest"
        fi
    done
}

# Check if any arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 repository1 repository2 ..."
    exit 1
fi

# Loop through each team name and pull images
for team in "$@"; do
    pull_images "$team"
done
