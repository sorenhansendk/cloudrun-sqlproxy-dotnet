using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace CloudRunDemo.Controllers
{
    [ApiController]
    [Route("")]
    public class DefaultController : ControllerBase
    {
        public IConfiguration Configuration { get; }

        public DefaultController(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        [HttpGet]
        public IActionResult Get()
        {
            using (var connection = new NpgsqlConnection(GetConnectionString()))
            {
                connection.Open();
            }

            return Ok("Welcome!");
        }

        private string GetConnectionString()
        {
            var settings = Configuration.GetSection("Database").Get<DatabaseSettings>();

            var connectionString = new NpgsqlConnectionStringBuilder()
            {
                Host = settings.Hostname,
                Username = settings.Username,
                Password = settings.Password,
                Database = settings.Database,
                SslMode = SslMode.Disable,
            };

            connectionString.Pooling = true;
            connectionString.Timeout = 15;
            connectionString.MinPoolSize = 0;
            connectionString.MaxPoolSize = 5;
            connectionString.ConnectionIdleLifetime = 300;

            return connectionString.ConnectionString;
        }
    }

    public class DatabaseSettings
    {
        public string Hostname { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Database { get; set; }
    }
}
