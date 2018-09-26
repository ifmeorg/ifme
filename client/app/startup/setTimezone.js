// @flow
import * as jstz from 'jstimezonedetect';
import Cookies from 'universal-cookie';

const cookies = new Cookies();
cookies.set('timezone', jstz.determine().name());
