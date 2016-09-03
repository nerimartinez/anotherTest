var myApp = angular.module('myApp', ['ngRoute'])

//ng-route config
.config(function ($routeProvider, $locationProvider) {
    $routeProvider
        .when('/home', {
            templateUrl: 'default.html'
        })
        .when('/contact-info/:contact_index', {
            templateUrl: 'contact_info.html',
            controller: 'contactInfoCtrl'
        })
        .otherwise({ redirectTo: '/home' });
})

//filter
.filter('sarasa', function (sharedData, TagData) {
    return function (input, text) {

        var out = [];
        if (!text || text == '#') {
            out = input;
            return out;
        }
        text = text.toLowerCase();

        if (!text.startsWith('#')) {
            angular.forEach(input, function (con) {
                if (con.FirstName.toLowerCase().indexOf(text) > -1 | con.LastName.toLowerCase().indexOf(text) > -1 | con.CompanyName.toLowerCase().indexOf(text) > -1) {
                    out.push(con);
                }
            })
        } else {
            { tags = sharedData.getTags() }
            var filteredTags = [];
            var tagText = text.replace('#', '');

            angular.forEach(tags, function (tag) {
                if (tag.Name.toLowerCase().indexOf(tagText) > -1) {
                    filteredTags.push(tag.Id);
                }
            })

            angular.forEach(input, function (key, val) {
                if (key.TagIds != null) {
                    var t = [];
                    t = key.TagIds;
                    for (i = 0; i < t.length; i++) {
                        if (key.TagIds.indexOf(filteredTags[i]) > -1) {
                            out.push(key);
                            break;
                        }
                    }
                }
            });
        }
        return out;
    }
})

// controllers

.controller('homeCtrl', function ($scope, $rootScope, ContactData, TagData, sharedData) {

    if (sharedData.tags) {
        $scope.tags = sharedData.getTags();
        if (sharedData.contacts) { $scope.contacts = sharedData.getContacts(); } else {
            ContactData.getContacts().success(function (data) {
                sharedData.setContacts(data);
                $scope.contacts = data;
            }).error(function () { });
        }
    } else {
        TagData.getTags().success(function (data1) {
            sharedData.setTags(data1);
            $scope.tags = data1;
            if (sharedData.contacts) { $scope.contacts = sharedData.getContacts(); } else {
                ContactData.getContacts().success(function (data) {
                    sharedData.setContacts(data);
                    $scope.contacts = data;
                }).error(function () { });
            }
        }).error(function () { });
    }

    $scope.mapNames = function (item) {
        $scope.tags = sharedData.getTags();
        return $.grep(
            $scope.tags,
            function (e) {
                return e.Id == item;
            })[0];
    };

    $scope.setId = function (id) {
        var t = id;
        sharedData.Id = id;
    };
})

.controller('contactInfoCtrl', function ($scope, $routeParams, ContactData, TagData, sharedData) {
    if (sharedData.contacts) {
        $scope.contacts = sharedData.getContacts();
        var index = $routeParams.contact_index;

        $scope.currentContact = $scope.contacts[index];
    } else {
        ContactData.getContacts().success(function (data) {
            sharedData.setContacts(data);
            $scope.contacts = data;
            var index = $routeParams.contact_index;

            $scope.currentContact = $scope.contacts[index];
        }).error(function () { });
    }
})

.controller('contactTagsCtrl', function ($scope, $routeParams, ContactData, TagData) {

    $scope.tags = TagData.getTags();
    $scope.contacts = ContactData.getContacts();

    $scope.index = $routeParams.contact_index;
    $scope.tag = $scope.tags[$scope.index];
})

.controller('tagsCtrl', function ($scope, $routeParams, ContactData, TagData, sharedData) {

    $(function () {

        $("ul.dropdown-menu").on("click", "[data-keepOpenOnClick]", function (e) {
            e.stopPropagation();
        });
    });

    $scope.editMode = false;
    $scope.editText = 'Edit';
    $scope.sharedData = sharedData;

    $scope.add = function () {
        var id;
        TagData.addTag($scope.name).success(function (data1) {
            var newTag = { Id: data1, Name: $scope.name }

            $scope.tags.push(newTag);
            $scope.name = '';
        });
    }

    $scope.isChecked = function ($c, $tag) {

        if (sharedData.contacts) { $scope.contacts = sharedData.contacts; } else {
            ContactData.getContacts().success(function (data) {
                sharedData.contacts = data;
                $scope.contacts = data;
            }).error(function () { });
        }
        if (sharedData.Id == undefined) {
            return false;
        }
        var id = sharedData.Id;
        $scope.currentContact = $scope.contacts[id];
        return $scope.currentContact.TagIds != null && $scope.currentContact.TagIds.indexOf($tag.Id) > -1
    }

    $scope.change = function ($currentContact, $tag) {
        var aux = sharedData.getContactById($currentContact.Id);
        var index = aux.TagIds.indexOf($tag.Id);

        if (index > -1) {
            aux.TagIds.splice(index, 1);
            sharedData.updateContact(aux);
            ContactData.deleteTagFromContact(aux.Id, $tag.Id);
        } else {
            aux.TagIds.push($tag.Id);
            sharedData.updateContact(aux);
            var t = sharedData.getContactById($currentContact.Id);
            ContactData.addTagToContact(aux.Id, $tag.Id);
        }
    }

    $scope.del = function ($tag) {
        var index = $scope.tags.indexOf($tag);
        $scope.tags.splice(index, 1);
        TagData.deleteTag($tag.Id);

        angular.forEach($scope.contacts, function (key, val) {

            var aux = sharedData.getContactById(key.Id);
            var index = aux.TagIds.indexOf($tag.Id);

            if (index > -1) {
                aux.TagIds.splice(index, 1)
                sharedData.updateContact(aux);
            }
        });
    }

    $scope.edit = function () {
        if (!$scope.editMode) {
            $scope.editText = 'Done';
        } else {
            $scope.editText = 'Edit';
        }
        $scope.editMode = !$scope.editMode;
    }

    $scope.update = function ($tag) {
        sharedData.updateTag($tag);
        TagData.updateTag($tag.Id, $tag.Name);
    }
})

// directives

.directive('autoComplete', function (sharedData, ContactData, TagData) {

    return function postLink($scope, iElement, iAttrs) {
        var contacts;
        var tags;

        var inputSource;
        $(function () {
            TagData.getTags().success(function (data1) {
                sharedData.setTags(data1);
                tags = data1;

                ContactData.getContacts().success(function (data) {

                    sharedData.contacts = data;
                    contacts = data;
                    inputSource = jQuery.map(contacts, function (n, i) {
                        return n.FirstName
                    })
                        .concat(jQuery.map(contacts, function (n, i) {
                            return n.LastName
                        }))
                        .concat(jQuery.map(contacts, function (n, i) {
                            return n.CompanyName
                        }))
                        .concat(jQuery.map(tags, function (n, i) {
                            return "#" + n.Name
                        }));

                    $("#auto").autocomplete({
                        source: inputSource,
                        select: function (event, ui) {
                            $scope.searchText = ui.item.label;
                            $scope.$apply();
                            $scope.$digest();
                        }
                    });
                }).error(function () { });
            })
        });
    }
})

.directive('contact', function () {
    return {
        restrict: 'E',
        replace: true,
        templateUrl: 'contact.html'
    }
})

.directive('tagsa', function () {
    return {
        restrict: 'E',
        replace: true,
        templateUrl: 'tagsa.html'
    }
})

.service('sharedData', function () {
    var contacts;
    var tags;
    var Id = 0;

    this.setContacts = function (c) {
        contacts = c
    };

    this.getContacts = function () {
        return contacts
    };

    this.setTags = function (c) {
        tags = c
    };

    this.getTags = function () {
        return tags
    };

    this.updateContact = function (c) {
        var result;
        $.grep(
            contacts,
            function (e) {
                if (e.Id == c.Id)
                    result = e;
            });
        contacts[contacts.indexOf(result)] = c;
    };

    this.updateTag = function (t) {
        var result;
        $.grep(
            tags,
            function (e) {
                if (e.Id == t.Id)
                    result = e;
            });
        tags[tags.indexOf(result)] = t;
    };

    this.addTag = function (t) {
        tags.push(t);
    };

    this.getContactById = function (id) {
        var result;
        $.grep(
            contacts,
            function (e) {
                if (e.Id == id)
                    result = e;
            });
        return result;
    };
})

// services
.service('ContactData', function ($http) {
    this.getContacts = function () {
        return $http({
            method: "GET",
            url: "/api/contact",
            cache: true
        });
    }

    this.addTagToContact = function (contactId, tagId) {
        $http({
            method: "POST",
            url: "/api/contact",
            contentType: "application/json",
            data: {
                ContactId: contactId,
                TagId: tagId
            }
        });
    };

    this.deleteTagFromContact = function (contactId, tagId) {
        $http({
            method: "DELETE",
            url: "/api/contact?contactId=" + contactId + "&tagId=" + tagId,
            contentType: "application/json"
        });
    };
})

.factory('TagData', ['$http', function ($http) {

    var factory = {};

    factory.addTag = function (name) {
        return $http.post("/api/tag", '"' + name + '"');
    };

    factory.deleteTag = function (id) {
        $http({
            method: "DELETE",
            url: "/api/tag?id=" + id
        });
    };

    factory.updateTag = function (id, name) {
        $http({
            method: "PUT",
            url: "/api/tag",
            contentType: "application/json",
            data: {
                Id: id,
                Name: name
            }
        });
    };

    factory.getTags = function () {
        return $http({
            method: "GET",
            url: "/api/tag"
        });
    }
    return factory;
}])
