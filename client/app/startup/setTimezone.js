// @flow
import * as jstz from 'jstimezonedetect';
<<<<<<< HEAD
import Cookies from 'universal-cookie';

const cookies = new Cookies();
cookies.set('timezone', jstz.determine().name());
=======
import Cookies from 'js-cookie';

Cookies.set('timezone', jstz.determine().name());
>>>>>>> 426c92e1c86992eb551dab6f873560b76991f939
