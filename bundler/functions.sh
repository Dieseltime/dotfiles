##
# Bundler functions
#
# Runs bundle install in specified directory names.
# Leave arguments empty to bundle all project directories.
#
# Example: bundleall project1 project2 project3

bundleall () {
  if [ -z $PROJECTS_DIR ]; then ohno "PROJECT_DIR not set"; exit; fi
  working_dir=$(pwd)

  # Check if project names were supplied
  if [ -z $1 ]; then
    local folders=$(basename $PROJECT_DIR/*)
  else
    local folders=$@
  fi

  for folder in $folders; do
    if [ -d $PROJECTS_DIR/$folder ]; then
      # change to project directory and load specififed ruby version and gemset
      ohai "cd $PROJECT_DIR/$folder"
      cd $PROJECT_DIR/$folder
      if [ -f Gemfile ]; then
        ohai "bundle install"
        bundle install;
      fi
    else
      ohno "Directory $PROJECTS_DIR/$folder doesn't exist"
    fi
  done

  cd $working_dir
}
