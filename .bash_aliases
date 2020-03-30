dlogs() {
    cid=$(docker ps -f "name=$1" -q)
    lines=${2:-500}
    docker logs ${cid} --tail ${lines} -f
}

dbash() {
    cid=$(docker ps -f "name=$1" -q)
    docker exec -ti ${cid} bash
}
