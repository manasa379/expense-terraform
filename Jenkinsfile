pipeline {
   agent { lable 'workstation'}

   parameters{
     choice(name: 'ENV', choices: ['dev', 'Two', 'Three'], description: 'Pick something')
   }
       stages {
           stage('Terraform Plan') {
               steps {
                 sh 'terraform init -backend-config=env-${ENV}/state.tfvars'
                 sh 'terraform plan -var-file=env-${ENV}/input.tfvars'
               }
           }
       stage('Terraform Apply')
           steps {
             sh 'terraform apply -var-file=env-${ENV}/input.tfvars -auto-approve'

           }
       }
   }
}
