/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package org.superbiz.data;

import org.junit.Before;
import org.junit.Test;

import javax.ejb.EJB;
import javax.ejb.embeddable.EJBContainer;
import java.util.Collection;
import java.util.Properties;

import static org.junit.Assert.assertEquals;

/**
 * @version $Revision: 607077 $ $Date: 2007-12-27 06:55:23 -0800 (Thu, 27 Dec 2007) $
 */
public class SimpleUserRepositoryTests {

    @EJB
    private SimpleUserRepository repository;

    @Test
    public void test() throws Exception {

        repository.create("Quentin Tarantino", "Reservoir Dogs", 1992);
        repository.create("Joel Coen", "Fargo", 1996);
        repository.create("Joel Coen", "The Big Lebowski", 1998);

        Collection<User> list = repository.findAll();
        assertEquals("Collection.size()", 3, list.size());

        for (User user : list) {
            repository.remove(user.getPrimaryKey());
        }

        assertEquals("Movies.findAll()", 0, repository.findAll().size());
    }

    @Before
    public void setup() throws Exception {

        final Properties p = new Properties();
        p.put("movieDatabase", "new://Resource?type=DataSource");
        p.put("movieDatabase.JdbcDriver", "org.hsqldb.jdbcDriver");
        p.put("movieDatabase.JdbcUrl", "jdbc:hsqldb:mem:moviedb");

        EJBContainer.createEJBContainer(p).getContext().bind("inject", this);
    }
}
