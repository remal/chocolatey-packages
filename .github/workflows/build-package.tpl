    - name: Check {package} changes
      id: {package}-changes
      uses: tj-actions/changed-files@v11.6
      with:
        files: ^{package}/
    - name: Pack only: {package}
      if: ${{
        (steps.{package}-changes.outputs.any_changed == 'true' || steps.{package}-changes.outputs.any_deleted == 'true')
        && (
            (github.event_name == 'push' && github.ref != 'refs/heads/main')
            || github.event_name != 'push'
        )
        }}
      run: |
        pack "{package}"
    - name: Pack and publish: {package}
      if: ${{
        (steps.{package}-changes.outputs.any_changed == 'true' || steps.{package}-changes.outputs.any_deleted == 'true')
        && (
            (github.event_name == 'push' && github.ref == 'refs/heads/main')
        )
        && false
        }}
      run: |
        pack-and-push "{package}" "https://f.feedz.io/remal/chocolatey-packages/nuget" "${{secrets.FEEDZ_IO_TOKEN}}"
