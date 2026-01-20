test_image_name := "dotfiles-test"
test_dockerfile := "Dockerfile.test"

default:
    @just --list

build-test:
    docker build -t {{test_image_name}} -f {{test_dockerfile}} .
    
test: build-test
    docker run --rm -it {{test_image_name}} /bin/bash -c "./setup.sh -v; exec /bin/bash"

clean:
    docker rmi {{test_image_name}} 2>/dev/null || true
