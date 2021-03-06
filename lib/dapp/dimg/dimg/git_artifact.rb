module Dapp
  module Dimg
    class Dimg
      module GitArtifact
        def git_artifacts(omit_empty: true)
          [*local_git_artifacts(omit_empty: omit_empty), *remote_git_artifacts(omit_empty: omit_empty)].compact
        end

        def local_git_artifacts(omit_empty: true)
          @local_git_artifact_list ||= [].tap do |artifacts|
            break artifacts if (local_git_artifacts = Array(config._git_artifact._local)).empty?
            repo = GitRepo::Own.new(dapp)
            local_git_artifacts.map do |ga_config|
              artifacts.concat(generate_git_artifacts(repo, omit_empty: omit_empty, **ga_config._artifact_options))
            end unless repo.empty?
          end
        end

        def remote_git_artifacts(omit_empty: true)
          @remote_git_artifact_list ||= [].tap do |artifacts|
            Array(config._git_artifact._remote).each do |ga_config|
              repo = GitRepo::Remote.get_or_create(dapp, ga_config._name, url: ga_config._url)
              artifacts.concat(generate_git_artifacts(repo, omit_empty: omit_empty, **ga_config._artifact_options)) unless repo.empty?
            end
          end
        end

        def generate_git_artifacts(repo, omit_empty: true, **git_artifact_options)
          [].tap do |artifacts|
            artifacts << (artifact = ::Dapp::Dimg::GitArtifact.new(repo, self, ignore_signature_auto_calculation: ignore_signature_auto_calculation, **git_artifact_options))
            artifacts
          end.select do |artifact|
            !omit_empty || !artifact.is_empty
          end
        end

      end # GitArtifact
    end # Mod
  end # Dimg
end # Dapp
