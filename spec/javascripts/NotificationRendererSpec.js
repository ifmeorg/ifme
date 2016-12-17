var result;

function testNotification(dataOptions) {
  var data = $.extend({
    user: 'Plum',
    uniqueid: 'uuid'
  }, dataOptions);

  var notification = {
    uniqueid: 88,
    data: JSON.stringify(data)
  };

  result = new NotificationRenderer(notification).render();
}

describe('NotificationRenderer', function() {
  describe('comments', function() {
    var commentData = {
      commentid: 15,
      comment: 'this is a comment'
    };

    describe('moments', function() {
      describe('when cutoff is false', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            momentid: 5,
            moment: 'test moment',
            type: 'comment_on_moment',
            cutoff: false
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/moments/5">Plum commented "this is a comment" on test moment</a>');
        });
      });

      describe('when cutoff is true', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            momentid: 5,
            moment: 'test moment',
            type: 'comment_on_moment',
            cutoff: true
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/moments/5">Plum commented "this is a comment" [...] on test moment</a>');
        });
      });
    });

    describe('strategy', function() {
      describe('when cutoff is false', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            strategyid: 5,
            strategy: 'test strategy',
            type: 'comment_on_strategy',
            cutoff: false
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/strategies/5">Plum commented "this is a comment" on test strategy</a>');
        });
      });

      describe('when cutoff is true', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            strategyid: 5,
            strategy: 'test strategy',
            type: 'comment_on_strategy',
            cutoff: true
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/strategies/5">Plum commented "this is a comment" [...] on test strategy</a>');
        });
      });
    });

    describe('meeting', function() {
      describe('when cutoff is false', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            meetingid: 5,
            meeting: 'test meeting',
            type: 'comment_on_meeting',
            cutoff: false
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/meetings/5">Plum commented "this is a comment" on test meeting</a>');
        });
      });

      describe('when cutoff is true', function() {
        beforeEach(function() {
          testNotification($.extend(commentData, {
            meetingid: 5,
            meeting: 'test meeting',
            type: 'comment_on_meeting',
            cutoff: true
          }));
        });

        it('renders some html', function() {
          expect(result).toEqual('<a class="notification_link" id="88" href="/meetings/5">Plum commented "this is a comment" [...] on test meeting</a>');
        });
      });
    });
  });

  describe('ally requests', function() {
    describe('accepted', function() {
      beforeEach(function() {
        testNotification({
          uid: 3,
          type: 'accepted_ally_request'
        });
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/profile?uid=3">Plum accepted your ally request!</a>');
      });
    });

    describe('new request', function() {
      beforeEach(function() {
        testNotification({
          uid: 3,
          userid: 7,
          type: 'new_ally_request',
        });
      });

      it('renders some html', function() {
        expect(result).toEqual('<div id="88" class="small_margin_top"><a class="notification_link display_inline" href="/profile?uid=3">Plum</a> sent an ally request!<a rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="/allies/add?ally_id=7&refresh=/"><i class="fa fa-check"></i></a><a data-confirm="Are you sure?" rel="nofollow" data-method="post" class="notification_link small_margin_left display_inline" href="/allies/remove?ally_id=7&refresh=/"><i class="fa fa-times"></i></a></div>');
      });
    });
  });

  describe('groups', function() {
    var groupData = {
      group: 'test group',
      groupid: 7
    };

    describe('new group', function() {
      beforeEach(function() {
        testNotification($.extend(groupData, {
          type: 'new_group'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/groups/7">Plum created a group "test group"</a>');
      });
    });

    describe('new group member', function() {
      beforeEach(function() {
        testNotification($.extend(groupData, {
          type: 'new_group_member'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/groups/7">Plum joined your group "test group"</a>');
      });
    });

    describe('add group leader', function() {
      beforeEach(function() {
        testNotification($.extend(groupData, {
          type: 'add_group_leader'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/groups/7">Plum became a leader of "test group"</a>');
      });
    });

    describe('remove group leader', function() {
      beforeEach(function() {
        testNotification($.extend(groupData, {
          type: 'remove_group_leader'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/groups/7">Plum is no longer a leader of "test group"</a>');
      });
    });
  });

  describe('meetings', function() {
    var meetingData = {
      group: 'test group',
      groupid: 7,
      meeting: 'test meeting',
      meetingid: 13
    };

    describe('new meeting', function() {
      beforeEach(function() {
        testNotification($.extend(meetingData, {
          type: 'new_meeting'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/meetings/13">Plum created a new meeting "test meeting" for "test group"</a>');
      });
    });

    describe('remove meeting', function() {
      beforeEach(function() {
        testNotification($.extend(meetingData, {
          type: 'remove_meeting'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/groups/7">Plum has cancelled "test meeting" for "test group"</a>');
      });
    });

    describe('update meeting', function() {
      beforeEach(function() {
        testNotification($.extend(meetingData, {
          type: 'update_meeting'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/meetings/13">Plum has updated "test meeting" for "test group"</a>');
      });
    });

    describe('join meeting', function() {
      beforeEach(function() {
        testNotification($.extend(meetingData, {
          type: 'join_meeting'
        }));
      });

      it('renders some html', function() {
        expect(result).toEqual('<a class="notification_link" id="88" href="/meetings/13">Plum has joined "test meeting" for "test group"</a>');
      });
    });
  });
});
