# Usar uma imagem base do Ruby
FROM ruby:3.0.0

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configurar o diretório de trabalho
WORKDIR /myapp

# Copiar o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Copiar o restante do código do aplicativo
COPY . .

# Instalar o yarn para gerenciar pacotes JS
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Compilar ativos
RUN bundle exec rake assets:precompile

# Adicionar um script para corrigir problemas do PID do servidor
RUN echo "#!/bin/sh\nrm -f tmp/pids/server.pid\nexec \"\$@\"" > /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expor a porta que o Rails usa
EXPOSE 3000

# O comando padrão para iniciar o servidor Rails
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
