#!/bin/bash -eu

./render.sh

cd output
python -m http.server &
SERVER_PID=$!
cd ..

trap "kill $SERVER_PID" EXIT

while true; do
    inotifywait -qq -e modify,create,delete,move -r pages static template.html >/dev/null 2>&1
    echo "Change detected, rebuilding..."
    ./render.sh || echo "Build failed."
done
