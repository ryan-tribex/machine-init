#!/bin/bash

retries=5

# Function to pull images from a team's repository
pull_images() {
    team=$1
    # You can specify the tags you want to pull here, for example: tags=("latest" "v1.0" "v2.0")
    images=("main" "autonomy" "nlp" "asr" "vlm")
    tags=("grandfinals" "finals")
    for image in "${images[@]}"; do
        for tag in "${tags[@]}"; do
            attempt=1
            command="docker pull asia-southeast1-docker.pkg.dev/dsta-angelhack/repository-$team/$team-$image:$tag"
            while [ $attempt -le $retries ]; do
                echo "Attempt $attempt for $team for $image:$tag"
                $command && break
                ((attempt ++))
                echo "Retrying..."
                sleep 5
            done
        done
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
