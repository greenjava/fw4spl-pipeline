node('windows') {
    def workspace = pwd()
    
    //fix clone pipeline repository on slave
    stage "pipeline"
    def pipeline_repo_dir = "${workspace}\\pipeline"
    // clean old repositories
    if(fileExists("${pipeline_repo_dir}")){
        bat "rd /s /q \"${pipeline_repo_dir}\""
    }
    bat "git clone --depth=1 -b master https://github.com/greenjava/fw4spl-pipeline.git \"${pipeline_repo_dir}\""
    
    stage "environment"
    bat "if not exist \"${workspace}\\Src\"     mkdir \"${workspace}\\Src\""
    bat "if not exist \"${workspace}\\Build\"   mkdir \"${workspace}\\Build\""
    bat "if not exist \"${workspace}\\Install\" mkdir \"${workspace}\\Install\""
    
    def fw4spl_deps_branch = "fw4spl_0.11.0"
    def fw4spl_deps_repo_dir = "${workspace}\\Src\\fw4spl-deps"

    // clean old repositories
    if(fileExists("${fw4spl_deps_repo_dir}")){
        bat "rd /s /q \"${fw4spl_deps_repo_dir}\""
    }
    stage "checkout"
    bat "git clone --depth=1 -b ${fw4spl_deps_branch} https://github.com/fw4spl-org/fw4spl-deps.git \"${fw4spl_deps_repo_dir}\""
    
    stage "configure"
    bat "\"${pipeline_repo_dir}\\utils\\msvc.bat\" \
        cd \"${workspace}\\Build\" && \
        cmake \"${fw4spl_deps_repo_dir}\" \
              -G\"NMake Makefiles JOM\" \
              -DCMAKE_BUILD_TYPE=Debug \
              -DCMAKE_INSTALL_PREFIX:PATH=\"${workspace}\\Install\""

    stage "build"
    bat "\"${pipeline_repo_dir}\\utils\\msvc.bat\" \
        cd \"${workspace}\\Build\" && \
        jom zlib"
}
