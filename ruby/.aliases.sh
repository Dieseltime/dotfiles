alias pstart="start-passenger"
alias passenger-start="start-passenger"
alias pstop="stop-passenger"
alias passenger-stop="stop-passenger"
alias engine-spec="run_engine_spec"
alias engine-specs="run_all_engine_specs"
alias gc-specs="gc_specs"
alias date-test="date_test"
alias date-reset="date_reset"

# Set time to 4:00 PM for time zone testing
date_test () {
  sudo systemsetup -setusingnetworktime off && date --set="16:00"
}

date_reset () {
  sudo systemsetup -setusingnetworktime on && ntpdate -u time.apple.com
}

silently () {
  echo "${@}"
  $@ 2>&1 >/dev/null
}

verbosely () {
  echo "${@}"
  $@
}

setup_ruby_gc_exports () {
  export RUBY_GC_MALLOC_LIMIT=1000000000
  export RUBY_FREE_MIN=500000
  export RUBY_HEAP_MIN_SLOTS=40000
  export RUBY_GC_HEAP_INIT_SLOTS=1000000
  export RUBY_GC_HEAP_FREE_SLOTS=500000
  export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
  export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000
  export RUBY_GC_MALLOC_LIMIT_MAX=1000000000
  export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1
}

start_timer () {
  export SECONDS=0
}

stop_timer () {
  duration=$SECONDS
  if (( ($duration / 60) > 1 )); then
    ohai "Finished in $(($duration / 60)) minutes and $(($duration % 60)) seconds."
  else
    ohai "Finished in $(($duration % 60)) seconds."
  fi
}

gc_specs () {
  setup_ruby_gc_exports

  declare -a skip_me=(
    "spec/acceptance/clinic/messaging_settings.feature"
    "spec/acceptance/message_threads/staff_permissions.feature"
    "spec/acceptance/message_threads/staff_show.feature"
    "spec/acceptance/message_threads/new.feature"
  )

  for file in "${skip_me[@]}"
  do
    comment_file "$HOME/Code/gc/${file}"
  done

  cd "$HOME/Code/gc" && ./faster_parallel_test.sh

  for file in "${skip_me[@]}"
  do
    uncomment_file "$HOME/Code/gc/${file}"
  done

  stop_timer
}

run_engine_spec () {
  setup_ruby_gc_exports

  ohai "Running specs for $(basename $PWD)"
  echo ""

  export NO_SIMPLE_COV=true

  bundle check || bundle

  if [ -f "$PWD/spec/dummy/config/database.yml" ]; then
    silently bundle exec rake db:drop
    silently bundle exec rake db:create
    silently bundle exec rake db:schema:load
    silently bundle exec rake app:db:test:prepare
  fi

  verbosely bundle exec rspec spec --require "$HOME/Code/shutup_rspec.rb" --tag ~no_jenkins

  if [ -d "$PWD/spec/javascripts" ]; then
    # ignore this google charts spec for now
    if [[ "$PWD" =~ patient_mgmt ]]; then
      comment_file "$PWD/spec/javascripts/patient_mgmt/views/navigation_activity_report_spec.js.coffee"
    fi

    silently bundle exec rake app:tmp:clear
    verbosely bundle exec rake app:konacha:run

    if [[ "$PWD" =~ patient_mgmt ]]; then
      uncomment_file "$PWD/spec/javascripts/patient_mgmt/views/navigation_activity_report_spec.js.coffee"
    fi
  fi

  echo ""
}

comment_file () {
  sed -i -e 's/^/#/' $1
}

uncomment_file () {
  sed -i -e 's/^#//' $1
}

run_all_engine_specs () {
  start_timer

  cd "$HOME/Code/navigatingcare-components/patient_ui"          && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/care_planning"       && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/ironclad"            && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/care_management"     && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/distress"            && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/patient_groups"      && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/patient_navigation"  && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/triage_pathways"     && run_engine_spec
  cd "$HOME/Code/navigatingcare-components/patient_mgmt"        && run_engine_spec
  cd "$HOME/Code/navigatingcare-components"

  stop_timer
}