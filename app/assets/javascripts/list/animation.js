$(function() {
  var tween1 = KUTE.to('#dango-one', {
    borderRadius: '100%',
    rotate: 405,
    backgroundColor: 'red'
  }, {
    repeat: 1,
    yoyo: true,
    complete: function() {}
  });

  var tween2 = KUTE.to('#dango-two', {
    borderRadius: '100%',
    rotate: 810,
    backgroundColor: 'yellow'
  }, {
    repeat: 1,
    yoyo: true,
    complete: function() {}
  });

  var tween3 = KUTE.to('#dango-three', {
    borderRadius: '100%',
    rotate: 1205,
    backgroundColor: 'blue'
  }, {
    repeat: 1,
    yoyo: true,
    complete: function() {}
  });

  $('.btn').on('click', function() {
    tween1.start();
    tween2.start();
    tween3.start();
  });
});
