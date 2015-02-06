u1 = User.create({first_name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role: 'Regular'})
u2 = User.create({first_name: 'Sue', email: 'sue@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role: 'Regular'})
u3 = User.create({first_name: 'Kev', email: 'kev@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role: 'Regular'})
u4 = User.create({first_name: 'Jack', email: 'jack@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role: 'Admin'})

p1 = Post.create({title: 'Winter', content: 'Cold and rainy', user_id: u2.id})
p2 = Post.create({title: 'Spring', content: 'Warm and rainy', user_id: u2.id})
p3 = Post.create({title: 'Summer', content: 'Hot and sometimes rainy', user_id: u1.id})
p4 = Post.create({title: 'Autumn', content: 'Warm and rainy', user_id: u3.id})
