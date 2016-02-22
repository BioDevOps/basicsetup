for repository in "$@"; do
    echo "Processing:\t $repository"
    python ./scripts/api/install_tool_shed_repositories.py --api admin -l http://localhost:8080 --tool-deps --repository-deps $repository
done
