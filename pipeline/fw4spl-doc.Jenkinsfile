node('docker') {
    def workspace = pwd()
    
    //fix clone pipeline repository on slave
    stage "pipeline"
    def pipeline_repo_dir = "${workspace}/pipeline/"
    // clean old repositories
    sh "rm -rf ${pipeline_repo_dir}"
    sh "git clone --depth=1 -b ${fw4spl_branch} https://github.com/greenjava/fw4spl-pipeline.git ${pipeline_repo_dir}"
        
    stage "docker"
    def docker_context = "${pipeline_repo_dir}/docker"
    def fw4spl_docker = docker.build("fw4spl_ubuntu:14.04",
                                     "-f ${docker_context}/fw4spl-ubuntu-14.04.Dockerfile ${docker_context}")
    fw4spl_docker.inside("-u root:root") {
    
        stage "environment"
        sh "mkdir -p ${workspace}/Src && \
            mkdir -p ${workspace}/Build && \
            mkdir -p ${workspace}/Install"
        
        def fw4spl_branch = "fw4spl_0.11.0"
        def fw4spl_repo_dir = "${workspace}/Src/fw4spl"
        def fw4spl_ar_repo_dir = "${workspace}/Src/fw4spl-ar"

        // clean old repositories
        sh "rm -rf ${fw4spl_repo_dir}"
        sh "rm -rf ${fw4spl_ar_repo_dir}"
        
        stage "checkout"
        sh "git clone --depth=1 -b ${fw4spl_branch} https://github.com/fw4spl-org/fw4spl.git ${fw4spl_repo_dir}"
        sh "git clone --depth=1 -b ${fw4spl_branch} https://github.com/fw4spl-org/fw4spl-ar.git ${fw4spl_ar_repo_dir}"
        
        stage "configure"
        sh "cd ${workspace}/Build && \
            cmake ${fw4spl_repo_dir} \
                  -DADDITIONAL_PROJECTS:PATH=${fw4spl_ar_repo_dir} \
                  -DCMAKE_INSTALL_PREFIX:PATH=${workspace}/Install \
                  -DBUILD_DOCUMENTATION:BOOL=ON \
                  -DBUILD_TESTS:BOOL=OFF"

        stage "build"
        sh "cd ${workspace}/Build && \
            make doc"
    }
}
