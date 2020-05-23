# frozen_string_literal: true
describe MomentsHelper, type: :controller do
  let(:user) { create(:user1) }
  let(:moment) { FactoryBot.create(:moment, :with_secret_share, user: user) }

  controller(MomentsController) do
  end

  describe '#secret_share_props' do
    it 'returns the correct input' do
      input = { inputs: [
        {
          id: 'secretShare',
          type: 'text',
          name: 'secretShare',
          label: I18n.t('moments.secret_share.singular'),
          readOnly: true,
          value: secret_share_url(moment.secret_share_identifier),
          dark: true,
          copyOnClick: I18n.t('moments.secret_share.link_copied')
        }
      ], action: moment_path(moment) }
      expect(controller.secret_share_props(moment)).to eq(input)
    end
  end

  describe '#present_moment_or_strategy' do
    context 'for a moment' do
      let(:moment) { create(:moment, user: user) }
      subject { controller.present_moment_or_strategy(moment) }
      it 'returns correct data' do
        expect(subject.keys).to include(:name, :link, :actions, :storyType, :date)
        expect(subject[:link]).to eq(moment_path(moment))
        expect(subject[:name]).to eq(moment[:name])
      end
    end

    context 'for a strategy' do
      let(:strategy) { create(:strategy, user: user) }
      subject { controller.present_moment_or_strategy(strategy) }
      it 'returns correct data' do
        expect(subject.keys).to include(:name, :link, :actions, :storyType, :date)
        expect(subject[:link]).to eq(strategy_path(strategy))
        expect(subject[:name]).to eq(strategy[:name])
      end
    end
  end

  describe '#get_resources_data' do
    context 'when current_user is a moment author' do
      let(:current_user) { user }
      context 'when a moment is created in the past' do
        let(:created_at) { '2014-01-01 00:00:00' }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created now' do
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to true' do
            expect(subject).to eq({
              show_crisis_prevention: true,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to true' do
            expect(subject).to eq({
              show_crisis_prevention: true,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created in the past and updated now' do
        let(:created_at) { '2014-01-01 00:00:00' }
        let(:updated_at) { Time.zone.now }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to true' do
            expect(subject).to eq({
              show_crisis_prevention: true,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to true' do
            expect(subject).to eq({
              show_crisis_prevention: true,
              tags: ''
            })
          end
        end
      end
    end

    context 'when current_user is not a moment author' do
      let(:current_user) { create(:user2) }
      context 'when a moment is created in the past' do
        let(:created_at) { '2014-01-01 00:00:00' }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created now' do
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created in the past and updated now' do
        let(:created_at) { '2014-01-01 00:00:00' }
        let(:updated_at) { Time.zone.now }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: 'tech industry', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=tech industry&'
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: 'dog', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces the correct tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: 'filter[]=anxiety&'
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end
    end

    context 'when a moment has secret share enabled' do
      let(:current_user) { nil }
      context 'when a moment is created in the past' do
        let(:created_at) { '2014-01-01 00:00:00' }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'tech industry', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'dog', user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: created_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created now' do
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'tech industry', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'dog', user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself.", user: user) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end

      context 'when a moment is created in the past and updated now' do
        let(:created_at) { '2014-01-01 00:00:00' }
        let(:updated_at) { Time.zone.now }
        context 'when no crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'tech industry', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when no crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: 'dog', user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is a tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself. My anxiety is really bad.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end

        context 'when a crisis prevention modal is necessary and there is no tagged resource' do
          let(:moment) { create(:moment, :with_secret_share, name: "I'm struggling a lot and want to hurt myself.", user: user, created_at: created_at, updated_at: updated_at) }
          subject { controller.get_resources_data(moment, current_user) }
          it 'produces no tags and sets show_crisis_prevention to false' do
            expect(subject).to eq({
              show_crisis_prevention: false,
              tags: ''
            })
          end
        end
      end
    end
  end
end
