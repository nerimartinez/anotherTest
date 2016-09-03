using DataAccess;
using DataAccess.IRepositories;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using test.Models;

namespace testAvnon.API
{
    public class ContactController : ApiController
    {
        private IContactRepository _contactRepository;
        private IContactTagRepository _contactTagRepository;

        public ContactController(IContactRepository contactRepository, IContactTagRepository contactTagRepository)
        {
            _contactRepository = contactRepository;
            _contactTagRepository = contactTagRepository;
        }

        [HttpGet]        
        public List<Contact> GetAll()
        {   
            return _contactRepository.GetContactsWithTagIds();            
        }

        public int Post([FromBody]ContactTagVM vm)
        {
            return _contactTagRepository.Add(vm.ContactId, vm.TagId);
        }

        public void Delete(int contactId, int tagId)
        {
            _contactTagRepository.Delete(contactId, tagId);
        }
    }
}
