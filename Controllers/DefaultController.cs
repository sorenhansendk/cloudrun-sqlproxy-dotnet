using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace CloudRunDemo.Controllers
{
    [ApiController]
    [Route("/")]
    public class DefaultController : ControllerBase
    {
        public DefaultController()
        {

        }

        [HttpGet]
        public IActionResult Get()
        {
            return Ok("Welcome!");
        }
    }
}
