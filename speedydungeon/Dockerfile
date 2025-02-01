FROM ubuntu:latest

# Install necessary dependencies
RUN apt update && apt install -y libgl1-mesa-glx

# Set the working directory inside the container
WORKDIR /SpeedyDungeon

# Copy the exported game into the container
COPY export/SpeedyDungeon.x86_64 /SpeedyDungeon/SpeedyDungeon.x86_64

# Give execute permission to the game file
RUN chmod +x /SpeedyDungeon/SpeedyDungeon.x86_64

# Run the game when the container starts
CMD ["./SpeedyDungeon.x86_64"]
