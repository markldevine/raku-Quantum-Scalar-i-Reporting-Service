use Cro::HTTP::Router;

sub routes() is export {
    route {
        get -> {
            content 'text/html', "<h1> Quantum-Scalar-i-Reporting-Service </h1>";
        }
        get -> 'favicon.ico'    { static 'assets/favicon.ico'; }
    }
}
