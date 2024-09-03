import { z } from 'zod';

// add in the validation logic for the profile schema
export const playerSchema = z.object({
  email: z.string().email(),
  firstname: z.string().min(2).max(60),
  surname: z.string().min(6),
  gender: z.enum(["Male", "Female", "Other"]),
  dob: z.date(),
  england_squash_id: z.string(),
  squash_levels_id: z.string(),
});

export type FormSchema = typeof playerSchema;
