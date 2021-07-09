FROM ruby:3.0.1

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    nodejs \
    yarn

WORKDIR /usr/local/app

COPY Gemfile ./

COPY Gemfile.lock ./

RUN bundle

COPY package.json ./

COPY yarn.lock ./

RUN yarn

COPY . ./
