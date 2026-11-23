"use client";

import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { CustomEase } from "gsap/CustomEase";
import { useGSAP } from "@gsap/react";

// One place to register plugins and the house ease (strong ease-out from the animate skill).
gsap.registerPlugin(useGSAP, ScrollTrigger, CustomEase);
CustomEase.create("eri-out", "0.23,1,0.32,1");

export { gsap, ScrollTrigger, useGSAP };
