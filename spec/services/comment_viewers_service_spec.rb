# frozen_string_literal: true

describe CommentViewersService do
  let(:owner) { FactoryBot.create(:user2, :with_allies) }
  let(:ally) { owner.allies.first }
  let(:ally_commenter) { owner.allies.second }
  let(:strategy) { FactoryBot.create(:strategy, user_id: owner.id) }
  let(:moment) { FactoryBot.create(:moment, user_id: owner.id) }
  let(:commentable) do
    {
      strategy: strategy,
      moment: moment
    }
  end
  %i[strategy moment].each do |commentable_name|
    let(:my_commentable) { commentable[commentable_name] }
    let(:comment) do
      Comment.create!(commentable_type: commentable_name,
                      commentable_id: my_commentable.id,
                      comment_by: commenter.id,
                      comment: 'test comment',
                      visibility: visibility,
                      viewers: viewers)
    end
  end

  describe '#viewers' do
    subject { CommentViewersService.viewers(comment, current_user) }

    context 'private comments (visible to you and 1 ally)' do
      let(:visibility) { 'private' }

      context 'and comment was made by owner' do
        let(:commenter) { owner }
        let(:viewers) { [ally.id] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it "has the ally's name in visibility" do
            expect(subject).to eq("Visible only between you and #{ally.name}")
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it "has the owner's name in visibility" do
            expect(subject).to eq("Visible only between you and #{owner.name}")
          end
        end
      end

      context 'and comment was made by an ally' do
        let(:commenter) { ally_commenter }
        let(:viewers) { [] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it "has the ally's name in visibility" do
            expect(subject).to eq("Visible only between you and #{ally_commenter.name}")
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { ally_commenter }

          it "has the owner's name in visibility" do
            expect(subject).to eq("Visible only between you and #{owner.name}")
          end
        end
      end
    end

    context 'public comments (visible to all allies)' do
      let(:visibility) { 'all' }
      let(:viewers) { [] }

      context 'and comment was made by owner' do
        let(:commenter) { owner }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'has nothing for visibility' do
            expect(subject).to be_nil
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it 'has nothing for visibility' do
            expect(subject).to be_nil
          end
        end
      end

      context 'and comment was made by ally' do
        let(:commenter) { ally_commenter }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'has nothing for visibility' do
            expect(subject).to be_nil
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { commenter }

          it 'has nothing for visibility' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end

  describe '#viewable?' do
    subject { CommentViewersService.viewable?(comment, current_user) }

    context 'private comments (visible to you and 1 ally)' do
      let(:visibility) { 'private' }

      context 'and comment was made by owner' do
        let(:commenter) { owner }
        let(:viewers) { [ally.id] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end
      end

      context 'and comment was made by an ally' do
        let(:commenter) { ally_commenter }
        let(:viewers) { [] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { ally_commenter }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end
      end
    end

    context 'public comments (visible to all allies)' do
      let(:visibility) { 'all' }
      let(:viewers) { [] }

      context 'and comment was made by owner' do
        let(:commenter) { owner }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it 'returns false' do
            expect(subject).to eq(false)
          end
        end
      end

      context 'and comment was made by ally' do
        let(:commenter) { ally_commenter }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { commenter }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end
      end
    end
  end

  describe '#deletable?' do
    subject { CommentViewersService.deletable?(comment, current_user) }

    context 'private comments (visible to you and 1 ally)' do
      let(:visibility) { 'private' }

      context 'and comment was made by owner' do
        let(:commenter) { owner }
        let(:viewers) { [ally.id] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it 'returns false' do
            expect(subject).to eq(false)
          end
        end
      end

      context 'and comment was made by an ally' do
        let(:commenter) { ally_commenter }
        let(:viewers) { [] }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { ally_commenter }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end
      end
    end

    context 'public comments (visible to all allies)' do
      let(:visibility) { 'all' }
      let(:viewers) { [] }

      context 'and comment was made by owner' do
        let(:commenter) { owner }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as ally' do
          let(:current_user) { ally }

          it 'returns false' do
            expect(subject).to eq(false)
          end
        end
      end

      context 'and comment was made by ally' do
        let(:commenter) { ally_commenter }

        context 'logged in as owner' do
          let(:current_user) { owner }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end

        context 'logged in as commenter' do
          let(:current_user) { commenter }

          it 'returns true' do
            expect(subject).to eq(true)
          end
        end
      end
    end
  end
end
