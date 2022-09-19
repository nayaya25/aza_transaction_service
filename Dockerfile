FROM ruby:2.7.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ADD . /aza_transaction_service
WORKDIR /aza_transaction_service
RUN bundle install
EXPOSE 3001
CMD ["bash"]