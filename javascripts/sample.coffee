$ -> 
  $('.age.now').attr('datetime', new Date)
  $('.age.default').age()
  $('.age.tiny').age(style: 'tiny')
  $('.age.expired').age(expired: 'expired')
  $('.age.pending').age(pending: 'pending')