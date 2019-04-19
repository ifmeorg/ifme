# frozen_string_literal: true
shared_examples :most_focus do |data_type|
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:profile) { user1 }
  let(:data_length) { 2 }
  let(:datum) { create(data_type, user_id: profile.id) }
  let(:data) { create_list(data_type, data_length, user_id: profile.id) }
  let(:data_ids) { data.map(&:id) }
  data_type_name = data_type.to_s

  before do
    sign_in user1
  end

  context "when no #{data_type_name.pluralize} exist" do
    it 'returns an empty hash' do
      expect(controller.most_focus(data_type_name, nil)).to be_nil
    end
  end

  context "when #{data_type_name.pluralize} exist" do
    subject { controller.most_focus(data_type_name, profile) }

    context "when the same #{data_type_name} is used twice" do
      before do
        create_list(:moment, 2, :with_published_at, data_type => [datum.id], user_id: profile.id)
      end

      it "includes duplicate #{data_type_name.pluralize} once" do
        expect(subject.length).to eq(1)
        expect(subject[datum.id]).to eq(2)
      end
    end

    context "when there are multiple #{data_type_name.pluralize}" do
      let(:data_length) { 4 }

      context 'when viewing your own profile' do
        before do
          create(:moment, :with_published_at, data_type => [datum.id], user_id: profile.id)
          create(:moment, :with_published_at, data_type => data_ids + [datum.id], user_id: profile.id)
        end

        it "returns a hash containing the top three unique #{data_type_name.pluralize}" do
          expect(subject.length).to eq(3)
          expect(subject[datum.id]).to eq(2)
        end
      end

      context "when viewing another user's profile" do
        let(:profile) { user2 }
        before do
          create(
            :moment,
            user_id: profile.id,
            data_type => [datum.id],
            viewers: [user1.id],
            published_at: time_stamp
          )
          create(
            :moment,
            user_id: profile.id,
            data_type => data_ids,
            published_at: time_stamp
          )
        end

        context 'when published' do
          let(:time_stamp) { Time.now.in_time_zone }

          it "shows only the #{data_type_name.pluralize} for which you have viewing permission" do
            expect(subject.length).to eq(1)
            expect(subject[datum.id]).to eq(1)
            data_ids.each do |id|
              expect(subject[id]).to be_nil
            end
          end
        end

        context 'when not published' do
          let(:time_stamp) { nil }

          it 'returns an empty hash' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end
