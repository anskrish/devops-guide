- gcloud projects add-iam-policy-binding testsrnadim --member serviceAccount:iac-gke@testsrnadim.iam.gserviceaccount.com --role roles/compute.admin

- gcloud projects add-iam-policy-binding testsrnadim --member serviceAccount:iac-gke@testsrnadim.iam.gserviceaccount.com --role roles/iam.serviceAccountUser

- gcloud projects add-iam-policy-binding testsrnadim --member serviceAccount:iac-gke@testsrnadim.iam.gserviceaccount.com --role roles/resourcemanager.projectIamAdmin

- gcloud projects add-iam-policy-binding testsrnadim --member serviceAccount:iac-gke@testsrnadim.iam.gserviceaccount.com --role roles/container.admin


- gsutil mb -p testsrnadim -c regional -l us-west3 gs://terraform-store-kri577

- gsutil iam ch serviceAccount:iac-gke@testsrnadim.iam.gserviceaccount.com:legacyBucketWriter gs://terraform-store-kri577/

