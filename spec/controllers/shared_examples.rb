require 'spec_helper'

shared_examples :most_focus do |data_type|
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:user_id) { user1.id }
  let(:data_length) { 2 }
  let(:datum) { create(data_type, user_id: user_id) }
  let(:data) { create_list(data_type, data_length, user_id: user_id) }
  let(:data_ids) { data.map(&:id) }
  data_type_name = data_type.to_s

  before do
    sign_in user1
  end

  context "when no #{data_type_name.pluralize} exist" do
    it 'returns an empty hash' do
      expect(controller.most_focus(data_type_name, nil)).to be_empty
    end
  end

  context "when #{data_type_name.pluralize} exist" do
    subject { controller.most_focus(data_type_name, user_id) }

    context "when the same #{data_type_name} is used twice" do
      before do
        create_list(:moment, 2, data_type => [datum.id], user_id: user_id)
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
          create(:moment, data_type => [datum.id], user_id: user_id)
          create(:moment, data_type => data_ids + [datum.id], user_id: user_id)
        end

        it "returns a hash containing the top three unique #{data_type_name.pluralize}" do
          expect(subject.length).to eq(3)
          expect(subject[datum.id]).to eq(2)
        end
      end

      context "when viewing another user's profile" do
        let(:user_id) { user2.id }
        let(:time_stamp) { Time.now }
        before do
          create(
            :moment,
            user_id: user_id,
            data_type => [datum.id],
            viewers: [user1.id],
            published_at: time_stamp
          )
          create(
            :moment,
            user_id: user_id,
            data_type => data_ids,
            published_at: time_stamp
          )
        end

        context 'when published' do
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
            expect(subject).to be_empty
          end
        end
      end
    end
  end
end
