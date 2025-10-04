# Assumes workdir: <attic> 

atticadm make-token --sub "runner" --validity "10y" \
    --pull "dev-github" --push "dev-github" --create-cache "dev-github" \
    --configure-cache "dev-github" --configure-cache-retention "dev-github" --destroy-cache "dev-github" \
    --delete "dev-github" \
    -f ./server.toml
