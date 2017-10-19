package MyWeb::App;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'MyWeb::App' };
};

get '/test' => sub {
  'Hello from Dancer2!';
};

get '/hello/:name' => sub {
  'Dancer2 welcomes you, ' . route_parameters->get('name');
};

true;

