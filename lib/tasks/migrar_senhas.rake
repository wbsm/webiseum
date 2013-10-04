# encoding: utf-8
namespace :app do
  	desc "Encripta todas as senhas \
        que ainda não foram processadas \
        no banco de dados"
	
	task migrar_senhas: :environment do
		unless User.attribute_names.include? "password"
			puts "As senhas ja foram migradas, terminando."
		end

		User.find_each do |user|
      		puts "Migrando usuario ##{user.id} #{user.full_name}"
      	
      		unencripted_password = user.attributes["password"]
      		
      		user.password = unencripted_password
      		user.password_confirmation = unencripted_password
      
      		if user.valid?
      			user.save!		
      		else 
      			puts "Erro salvando usuario : ##{user.id} - errors: ##{user.errors.messages}" 
      			user.destroy
      			
      		end
      	end
	end 
end