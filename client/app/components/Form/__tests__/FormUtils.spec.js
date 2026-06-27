// @flow
import { getNewInputs } from 'components/Form/utils';

describe('getNewInputs', () => {
  describe('for a required text input', () => {
    const input = {
      id: 'text-id',
      type: 'text',
      name: 'some[field]',
      required: true,
    };

    it('reports an error when the field is empty', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: {},
        refs: { 'text-id': { value: '' } },
      });
      expect(errors['text-id']).toBe(true);
    });

    it('reports no error when the field has a value', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: {},
        refs: { 'text-id': { value: 'hello' } },
      });
      expect(errors['text-id']).toBe(false);
    });

    it('clears a stale error when the field now has a value', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: { 'text-id': true },
        refs: { 'text-id': { value: 'hello' } },
      });
      expect(errors['text-id']).toBe(false);
    });
  });

  describe('for a required textareaTemplate input', () => {
    const input = {
      id: 'textarea-template-id',
      type: 'textareaTemplate',
      name: 'moment[why]',
      required: true,
    };

    it('reports an error when the field is empty', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: {},
        refs: { 'textarea-template-id': { value: '' } },
      });
      expect(errors['textarea-template-id']).toBe(true);
    });

    it('clears a stale error when the field now has a value', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: { 'textarea-template-id': true },
        refs: { 'textarea-template-id': { value: '<p>Hello</p>' } },
      });
      expect(errors['textarea-template-id']).toBe(false);
    });
  });

  describe('for a non-validated type without a DOM ref', () => {
    const input = {
      id: 'quickcreate-id',
      type: 'quickCreate',
      name: 'some[field]',
      required: true,
    };

    it('preserves an existing error set by component-level validation', () => {
      const { errors } = getNewInputs({
        inputs: [input],
        errors: { 'quickcreate-id': true },
        refs: {},
      });
      expect(errors['quickcreate-id']).toBe(true);
    });
  });
});
