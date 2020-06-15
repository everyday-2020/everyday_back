## bootstrap

1. prequisites
    - 루비 설치
    - (linux만) ruby-dev 설치
        * `sudo apt install ruby-dev` (ubuntu, debian)
        * `sudo dnf install ruby-devel` (rhel, centos, fedora)
    - postgres 설치
    - docker 설치(로컬 db로 개발할 거라면 안해도 상관없음)
1. 의존성 설치
    ```
    bundle install
    ```
1. db 구동
    * docker
    ```
    docker run -d --name everyday-db \
        -e POSTGRES_PASSWORD=everyday \
        -e POSTGRES_USER=everyday \
        -e POSTGRES_DB=everyday_development \
        -p 5432:5432 postgres:12.3
    ```

    * 로컬 db로 돌릴거면 아래 sql 실행
    ```sql
    create database everyday_development;
    create database everyday_test;
    create user everyday with encrypted password 'everyday';
    grant all privileges on database everyday_development to everyday;
    grant all privileges on database everyday_test to everyday;
    ```
1.  서버 구동
    ```
    rails s
    ```