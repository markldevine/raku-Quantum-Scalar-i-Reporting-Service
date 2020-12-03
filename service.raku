use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use Routes;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<QUANTUM_SCALAR_I_REPORTING_SERVICE_HOST> ||
        die("Missing QUANTUM_SCALAR_I_REPORTING_SERVICE_HOST in environment"),
    port => %*ENV<QUANTUM_SCALAR_I_REPORTING_SERVICE_PORT> ||
        die("Missing QUANTUM_SCALAR_I_REPORTING_SERVICE_PORT in environment"),
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<QUANTUM_SCALAR_I_REPORTING_SERVICE_HOST>:%*ENV<QUANTUM_SCALAR_I_REPORTING_SERVICE_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
