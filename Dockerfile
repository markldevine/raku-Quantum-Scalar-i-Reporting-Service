FROM croservices/cro-http:0.8.4
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN zef install --deps-only . && perl6 -c -Ilib service.raku
ENV QUANTUM_SCALAR_I_REPORTING_SERVICE_HOST="0.0.0.0" QUANTUM_SCALAR_I_REPORTING_SERVICE_PORT="10000"
EXPOSE 10000
CMD perl6 -Ilib service.raku
