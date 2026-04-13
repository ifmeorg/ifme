# frozen_string_literal: true

require 'spec_helper'

describe CommentsFormHelper, type: :controller do
  controller(ApplicationController) do
    include CommentsFormHelper
    helper_method :comment_form_props
  end

  describe '#comment_form_props' do
    let(:user1) { create(:user) }

    let(:submit_input) do
      {
        id: 'submit',
        type: 'submit',
        value: 'Submit',
        dark: true,
        name: 'commit'
      }
    end

    def default_inputs(comment_by, commentable_id, commentable_type)
      [
        { id: 'comment_commentable_type', name: 'comment[commentable_type]', type: 'hidden', value: commentable_type },
        { id: 'comment_comment_by', name: 'comment[comment_by]', type: 'hidden', value: comment_by },
        { id: 'comment_commentable_id', name: 'comment[commentable_id]', type: 'hidden', value: commentable_id },
        { id: 'comment_comment', name: 'comment[comment]', type: 'textarea', dark: true, value: nil, required: true, label: 'Comment' }
      ]
    end

    def owner_has_no_viewers_inputs(commentable_type, commentable_id)
      {
        # Ensure action uses the string version if the helper returns strings
        action: '/comments/create',
        inputs: default_inputs(user1.id, commentable_id, commentable_type) + [submit_input]
      }
    end

    # Use .deep_symbolize_keys to eliminate String vs Symbol mismatches
    subject { controller.comment_form_props(commentable, commentable_type).deep_symbolize_keys }

    before do
      allow(controller).to receive(:current_user).and_return(user1)
      # Stubbing this in case the helper calls it internally
      allow(controller).to receive(:comments_path).and_return('/comments/create')
    end

    context 'commentable type is a moment' do
      let(:commentable_type) { 'moment' }
      let(:commentable) { create(:moment, user_id: user1.id) }

      it 'returns correct props' do
        expect(subject).to eq(owner_has_no_viewers_inputs('moment', commentable.id))
      end
    end

    context 'commentable type is a meeting' do
      let(:commentable_type) { 'meeting' }
      let(:commentable) { create(:meeting) }

      it 'returns correct props for a leader' do
        create(:meeting_member, user: user1, meeting: commentable, leader: true)
        expect(subject).to eq(owner_has_no_viewers_inputs('meeting', commentable.id))
      end
    end
  end
end