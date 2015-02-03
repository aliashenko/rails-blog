r1 = Role.create({name: 'Regular', description: 'Can read and create posts. Can update and destroy own posts'})
r2 = Role.create({name: 'Admin', description: 'Can perform any CRUD operation on any resource'})

u1 = User.create({first_name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1})
u2 = User.create({first_name: 'Sue', email: 'sue@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1})
u3 = User.create({first_name: 'Kev', email: 'kev@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1})
u4 = User.create({first_name: 'Jack', email: 'jack@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r2})

p1 = Post.create({title: 'Winter', content: 'Cold and rainy', user_id: u2.id})
p2 = Post.create({title: 'Spring', content: 'Warm and rainy', user_id: u2.id})
p3 = Post.create({title: 'Summer', content: 'Hot and sometimes rainy', user_id: u1.id})
p4 = Post.create({title: 'Autumn', content: 'Warm and rainy', user_id: u3.id})
